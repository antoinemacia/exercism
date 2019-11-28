defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.replace(~r/(?![\p{L}\p{N}])[!\p{S}\p{Po}\p{Pc}]/u, " ")
    |> String.split(" ", trim: true)
    |> Enum.map(&String.downcase(&1))
    |> group_by_word
  end

  @spec group_by_word(list) :: map
  defp group_by_word(words) do
    Enum.reduce(words, %{}, fn word, map ->
      Map.update(map, word, 1, &(&1 + 1))
    end)
  end
end
