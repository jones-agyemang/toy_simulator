# Toy Robot Simulator

A command-line simulator for moving a toy robot on a square tabletop without
allowing it to fall over an edge.

The default table is 5 × 5 units. Coordinates start at `(0,0)`, and valid
positions range from `(0,0)` to `(4,4)`.

## Requirements

- Ruby 3.2.2 (declared in `.ruby-version`)
- Bundler

Confirm the active Ruby version and install the dependencies:

```sh
ruby -v
bundle install
```

## Running the simulator

The executable accepts commands from either a file or standard input.

### Read commands from a file

```sh
./bin/simulator fixtures/basic_movement.txt
```

Expected output:

```text
0,1,NORTH
```

### Read commands from standard input

```sh
echo 'PLACE 1,2,EAST\nMOVE\nMOVE\nLEFT\nMOVE\nREPORT\n' | ./bin/simulator
```

Expected output:

```text
3,3,NORTH
```

The simulator can also be used interactively. Enter one command per line and
send end-of-file when finished (`Ctrl-D` on macOS and Linux):

```sh
./bin/simulator
```

## Commands

| Command | Description |
| --- | --- |
| `PLACE X,Y,FACING` | Places or relocates the robot at the given coordinates, facing `NORTH`, `EAST`, `SOUTH`, or `WEST` |
| `MOVE` | Moves the robot one unit in its current direction |
| `LEFT` | Rotates the robot 90 degrees anticlockwise |
| `RIGHT` | Rotates the robot 90 degrees clockwise |
| `REPORT` | Prints the current position as `X,Y,FACING` |

For example:

```text
PLACE 0,0,NORTH
MOVE
REPORT
```

produces:

```text
0,1,NORTH
```

## Input behaviour and assumptions

- Commands are case-sensitive and must use the uppercase forms shown above.
- Blank lines and surrounding whitespace are ignored.
- Commands before the first valid `PLACE` have no effect.
- A later valid `PLACE` relocates the robot.
- A move that would leave the table is ignored; subsequent commands continue.
- Malformed commands, invalid orientations, negative coordinates, and
  out-of-bounds placements are ignored.
- Commands that take no arguments are ignored when arguments are supplied.
- Every valid `REPORT` produces its own line of output.

## Approach Explanation

The code separates command-line input, command dispatch, and domain behaviour:

- `bin/simulator` reads from files or standard input through Ruby's `ARGF`.
- `Simulator` parses each input line and dispatches recognised commands.
- Classes under `lib/commands` validate command-specific input and delegate the
  requested operation.
- `Robot` owns position, orientation, movement, and rotation rules.
- `Table` owns boundary checks.

Keeping table and robot rules outside the executable allows the domain logic to
be exercised directly and keeps the input mechanism replaceable.

## Tests and code quality

Run the complete test suite:

```sh
bundle exec rspec
```

Run the linter:

```sh
bundle exec rubocop
```

The specs cover individual commands, movement in every direction, rotations,
table boundaries, malformed input, multi-command scenarios, and both file and
standard-input execution.

## Possible future improvements

- Add optional diagnostics for ignored commands while keeping normal output
  limited to `REPORT` results
- Make the table dimensions configurable from the command line
