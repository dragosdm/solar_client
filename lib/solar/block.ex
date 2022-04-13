defmodule Solar.Block do
  @derive Jason.Encoder
  defstruct confirmations: nil,
            forged: %{
              amount: nil,
              burnedFee: nil,
              fee: nil,
              reward: nil,
              total: nil
            },
            generator: %{
              address: nil,
              publicKey: nil
            },
            height: nil,
            id: nil,
            payload: %{
              hash: nil,
              length: nil
            },
            previous: nil,
            signature: nil,
            timestamp: %{
              epoch: nil,
              human: nil,
              unix: nil
            },
            transactions: nil,
            version: nil
end
