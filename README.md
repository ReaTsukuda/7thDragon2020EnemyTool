# 7th Dragon 2020 Enemy Tool
This thing can take either raw .BIN files extracted from `init.tpk`, or each game's `init.tpk` itself, and extract basic enemy data. This includes names and stats; this does not include AI routines.

# Dependencies
None right now. You should be able to immediately open the solution in Visual Studio, or alternatively run `dotnet build` on it.

# unpack.rb
This respository comes with `unpack.rb`, a simple Ruby script for manually unpacking TPK archives. The syntax for running it is:

`ruby unpack.rb <TPK_FILENAME>`, where <TPK_FILENAME> is the name of the pack you want to unpack—for example, `init.tpk`.
