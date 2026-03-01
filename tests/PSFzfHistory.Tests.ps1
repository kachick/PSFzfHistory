Import-Module -Name .\PSFzfHistory\PSFzfHistory.psm1

InModuleScope PSFzfHistory {
    Describe 'Get-UniqueReverseHistory' {
        It 'returns unique history items in reverse (latest first) order' {
            $mockHistory = @(
                [PSCustomObject]@{ CommandLine = 'ls' },
                [PSCustomObject]@{ CommandLine = 'cd ..' },
                [PSCustomObject]@{ CommandLine = 'ls' },
                [PSCustomObject]@{ CommandLine = 'cat file' }
            )
            # Should be: 'cat file', 'ls', 'cd ..'
            $result = Get-UniqueReverseHistory $mockHistory
            $result | Should -BeExactly ('cat file', 'ls', 'cd ..')
        }
    }
}
