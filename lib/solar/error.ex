defmodule Solar.Error do
  @moduledoc """
  Solar Error data structure.
  """

  @derive Jason.Encoder
  defstruct status_code: nil,
            error: nil,
            message: nil
end
