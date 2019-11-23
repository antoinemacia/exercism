using System;
using System.Collections.Generic;
public static class Pangram
{
    public static bool IsPangram(string input)
    {
        IDictionary<char, int> charactersDict = new Dictionary<char, int>();
        foreach (char character in input.ToLower())
        {
            if(Char.IsLetter(character) && !charactersDict.ContainsKey(character))
            {
                charactersDict.Add(new KeyValuePair<char, int>(character, 1));
            }
        }
        return charactersDict.Count >= 26;
    }
}
