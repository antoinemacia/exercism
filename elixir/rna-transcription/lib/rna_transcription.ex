defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples
  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """

  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Stream.map( &to_rna_nucleotide(&1) )
    |> Enum.to_list
   end

  @spec to_rna_nucleotide(char) :: char
  defp to_rna_nucleotide(?G), do: ?C
  defp to_rna_nucleotide(?C), do: ?G
  defp to_rna_nucleotide(?T), do: ?A
  defp to_rna_nucleotide(?A), do: ?U
end
