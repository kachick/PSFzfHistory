Import-Module -Name .\PSFzfHistory\PSFzfHistory.psm1 -Force

InModuleScope PSFzfHistory {
    Describe 'Get-UniqueReverseHistory' {
        It 'returns unique history items in reverse (latest first) order' {
            $mockHistory = @(
                [PSCustomObject]@{ CommandLine = 'ls' },
                [PSCustomObject]@{ CommandLine = 'cd ..' },
                [PSCustomObject]@{ CommandLine = 'ls' },
                [PSCustomObject]@{ CommandLine = 'cat file' }
            )
            $result = Get-UniqueReverseHistory $mockHistory
            $result | Should -BeExactly ('cat file', 'ls', 'cd ..')
        }

        It 'preserves multiline history items' {
            $multiline = "function test {`n  echo 'hi'`n}"
            $mockHistory = @(
                [PSCustomObject]@{ CommandLine = 'ls' },
                [PSCustomObject]@{ CommandLine = $multiline }
            )
            $result = Get-UniqueReverseHistory $mockHistory
            $result[0] | Should -BeExactly $multiline
        }
    }

    Describe 'fzf integration' {
        It 'correctly passes and retrieves multiline items using fzf --read0' {
            $multiline = "function test {`n  echo 'hi'`n}"
            $items = @('ls', $multiline, 'cd ..')
            
            # 1. Join with NUL
            # 2. Pass to fzf --read0
            # 3. Filter to find the item
            $fzfOutput = $items -join "`0" | fzf --read0 --filter="function test"
            
            # Reconstruct the string if it was split by lines
            $reconstructed = $fzfOutput -join [System.Environment]::NewLine
            
            # Use Trim() to ignore trailing newline differences
            $reconstructed.Trim() | Should -BeExactly $multiline.Trim()
        }
    }
}
