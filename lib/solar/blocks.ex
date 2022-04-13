defmodule Solar.Blocks do
  @derive Jason.Encoder
  defstruct data: [],
            meta: nil

  defmodule Meta do
    @derive Jason.Encoder
    defstruct count: nil,
              first: nil,
              last: nil,
              next: nil,
              pageCount: nil,
              previous: nil,
              self: nil,
              totalCount: nil,
              totalCountIsEstimate: true
  end

  defmodule Transactions do
    @derive Jason.Encoder
    defstruct data: [],
              meta: nil
  end

  defmodule Transaction do
    @derive Jason.Encoder
    defstruct amount: nil,
              asset: %{
                votes: [],
                payments: []
              },
              blockId: nil,
              burnedFee: nil,
              confirmations: nil,
              fee: nil,
              id: nil,
              nonce: nil,
              recipient: nil,
              sender: nil,
              senderPublicKey: nil,
              signature: nil,
              type: nil,
              typeGroup: nil,
              version: nil
  end
end
