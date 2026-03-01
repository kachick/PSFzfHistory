Import-Module -Name .\PSFzfHistory\PSFzfHistory.psm1

InModuleScope PSFzfHistory {
    Describe 'AsOrderedSet' {
        It 'returns unique elements they are keep first appeared order in original' {
          ("foo", "bar", "foo", "baz", "f", "BAR", "bar") | AsOrderedSet | Should -BeExactly ('foo', 'bar', 'baz', 'f', 'BAR')
        }
    }

    Describe 'Reverse' {
        It 'reverses given list' {
          (1, 2, 3, 42, 987654321, 42) | Reverse | Should -BeExactly (42, 987654321, 42, 3, 2, 1)
        }
    }

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
