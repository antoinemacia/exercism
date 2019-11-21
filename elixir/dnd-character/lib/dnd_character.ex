defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a
  @initial_hitpoints 10

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    ((@initial_hitpoints - score) / 2)
    |> round_hitpoints
  end

  defp round_hitpoints(hitpoints), do: ceil(hitpoints) * -1

  @spec ability :: pos_integer()
  @spec ability :: nil
  def ability, do: Enum.random(3..18)

  @spec character :: t()
  def character do
    constitution = ability()
    %DndCharacter{
      strength: ability(),
      dexterity: ability(),
      constitution: constitution,
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability(),
      hitpoints: @initial_hitpoints + modifier(constitution)
    }
  end
end
