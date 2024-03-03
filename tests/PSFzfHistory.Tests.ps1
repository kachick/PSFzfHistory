Import-Module -Name .\src\PSFzfHistory.psm1

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
}
