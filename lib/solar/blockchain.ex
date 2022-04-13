defmodule Solar.Blockchain do
  @derive Jason.Encoder
  defstruct burned: %{
              fees: nil,
              total: nil,
              transactions: nil
            },
            supply: nil,
            block: %{height: nil, id: nil}
end
