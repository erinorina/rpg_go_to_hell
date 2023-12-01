# Go to hell tabletop rpg

Godot Engine v4.1.3.stable

To Do:

    - Fisher-Yates shuffle algorithm for dice roll in exploration/plain

The Fisher-Yates shuffle algorithm is a common method for randomly shuffling or reordering a finite sequence, like rolling random dice. Here's a brief overview of how it works:

Start by numbering the items in the sequence from 0 to n-1, where n is the total number of items. These will be the dice faces/values.

For each index i from n-1 down to 0:

Generate a random number from 0 to i
Swap the items at indices i and the randomly generated number
After the loop, the sequence will be randomly shuffled

Pseudocode:
```
function shuffle(array)
n = array.length
for i from n−1 downto 0 do
j = random integer such that 0 ≤ j ≤ i
exchange array[i] and array[j]
``
So for a 6-sided die, you would:

Number faces 1-6
Loop from 5 to 0
Pick random number from 0 to i (current index)
Swap faces at i and randomly picked number
Shuffled die faces
Repeating this each time a die is rolled ensures an even distribution
