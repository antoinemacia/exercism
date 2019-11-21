defmodule ProteinTranslation do
  @codon_length 3

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    rna
    |> String.codepoints
    |> Enum.chunk_every(@codon_length)
    |> Enum.reduce_while([], fn codon, acc ->
      case of_codon(Enum.join(codon)) do
        {:ok, "STOP"} -> {:halt, acc }
        {:ok, protein} -> {:cont, [ protein | acc ]}
        {:error, _} -> {:halt, {:error, "invalid RNA"}}
      end
    end)
    |> to_response_tuple
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) when codon in ~w(UGU UGC), do: {:ok, "Cysteine"}
  def of_codon(codon) when codon in ~w(UUA UUG), do: {:ok, "Leucine"}
  def of_codon("AUG"), do: {:ok, "Methionine"}
  def of_codon(codon) when codon in ~w(UUU UUC), do: {:ok, "Phenylalanine"}
  def of_codon(codon) when codon in ~w(UCU UCC UCA UCG), do: {:ok, "Serine"}
  def of_codon(codon) when codon in ~w(UUA UUG), do: {:ok, "Leucine"}
  def of_codon("UGG"), do: {:ok, "Tryptophan"}
  def of_codon(codon) when codon in ~w(UAU UAC), do: {:ok, "Tyrosine"}
  def of_codon(codon) when codon in ~w(UAA UAG UGA), do: {:ok, "STOP"}
  def of_codon(_), do: {:error, "invalid codon"}


  defp to_response_tuple({:error, message}), do: {:error, message}
  defp to_response_tuple(result), do: {:ok, result |> Enum.reverse}
end
