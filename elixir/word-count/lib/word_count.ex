defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.replace(~r"(?![a-zA-Z0-9\-])[!-~]|_", " ")
    |> String.split(" ")
    |> Enum.reject(&blank_word?(&1))
    |> Enum.map(&String.downcase(&1))
    |> group_by_word
  end

  @spec group_by_word(list) :: map
  defp group_by_word(words) do
    Enum.reduce(words, %{}, fn word, map ->
      if Map.has_key?(map, word) do
        Map.put(map, word, map[word] + 1)
      else
        Map.put(map, word, 1)
      end
    end)
  end

  @spec blank_word?(String.t()) :: boolean
  defp blank_word?(word) do
    String.trim(word) == ""
  end
end
