Import-Module -Name .\src\PSFzfHistory.psm1

InModuleScope PSFzfHistory {
    Describe 'AsOrderedSet' {
        It 'returns unique elements they are keep first appeared order in original' {
      (1, 2, 3, 42, 987654321, 42) | AsOrderedSet | Should -BeExactly (1, 2, 3, 42, 987654321)
        }
    }

    Describe 'Reverse' {
        It 'reverses given list' {
          (1, 2, 3, 42, 987654321, 42) | Reverse | Should -BeExactly (42, 987654321, 42, 3, 2, 1)
        }
    }
}
