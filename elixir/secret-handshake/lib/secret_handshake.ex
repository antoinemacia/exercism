use Bitwise

defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    write_handshake(code, [], :original)
  end

  @spec write_handshake(binary_code :: integer, handshake :: list(String.t()), order :: atom) :: list(String.t())
  defp write_handshake(binary_code, handshake, order) when binary_code > 0 do
    case binary_code do
      binary_code when ((binary_code &&& 16) == 16) ->
        write_handshake(binary_code - 16, handshake, :reverse)
      binary_code when ((binary_code &&& 8) == 8) ->
        write_handshake(binary_code - 8, ["jump" | handshake], order)
      binary_code when ((binary_code &&& 4) == 4) ->
        write_handshake(binary_code - 4, ["close your eyes" | handshake], order)
      binary_code when ((binary_code &&& 2) == 2) ->
        write_handshake(binary_code - 2, ["double blink" | handshake], order)
      binary_code when ((binary_code &&& 1) == 1) ->
        write_handshake(binary_code - 1, ["wink" | handshake], order)
      _ -> handshake
    end
  end
1
  defp write_handshake(0, handshake, :original) do handshake end
  defp write_handshake(0, handshake, :reverse) do Enum.reverse(handshake) end
end
