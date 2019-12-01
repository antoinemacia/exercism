defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase
    |> String.split(~r/[\s+\p{S}\p{Po}\p{Pc}]/u, trim: true)
    |> group_by_word
  end

  @spec group_by_word(list) :: map
  defp group_by_word(words) do
    Enum.reduce(words, %{}, fn word, map ->
      Map.update(map, word, 1, &(&1 + 1))
    end)
  end
end
