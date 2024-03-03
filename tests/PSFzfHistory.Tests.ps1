Import-Module -Name .\src\PSFzfHistory.psm1

InModuleScope PSFzfHistory {
    Describe 'Reverse' {
        It 'reverses given list' {
          (1, 2, 3, 42, 987654321, 42) | Reverse | Should -BeExactly (42, 987654321, 42, 3, 2, 1)
        }
    }
}
