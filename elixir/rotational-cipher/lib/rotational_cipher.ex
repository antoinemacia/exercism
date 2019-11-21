defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @alphabet_letters_count 26

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(fn char -> rotate_char(char, shift) end)
    |> List.to_string()
  end

  defp rotate_char(char, shift) when char in ?a..?z, do: ?a + rem((char - ?a) + shift, @alphabet_letters_count)
  defp rotate_char(char, shift) when char in ?A..?Z, do: ?A + rem((char - ?A) + shift, @alphabet_letters_count)
  defp rotate_char(char, _), do: char
end
