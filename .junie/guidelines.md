# Development Guidelines for Rrrog!

This document provides essential information for developers working on the Rrrog! project.

## Build/Configuration Instructions

### Prerequisites
- mruby (Ruby 3.2.1 or higher syntax)
- Taylor framework (the executable should be in the parent directory)

### Configuration
The project uses a `taylor-config.json` file for configuration:
```json
{
  "name": "taylor_game",
  "version": "v0.0.1",
  "input": "game.rb",
  "export_directory": "./exports",
  "export_targets": [
    "linux",
    "windows",
    "osx/apple",
    "osx/intel",
    "web"
  ],
  "load_paths": [
    "./",
    "./vendor"
  ],
  "copy_paths": [
    "./assets"
  ]
}
```

Key configuration options:
- `input`: The main entry point for the application (game.rb)
- `export_targets`: Supported platforms for exporting the game
- `load_paths`: Directories to include in the Ruby load path
- `copy_paths`: Directories to copy when exporting the game

### Running the Game
To run the game in development mode, use the `run.cmd` script which executes the Taylor framework:
```
..\taylor.exe
```

### Building for Distribution
To build the game for distribution, use the Taylor framework's export functionality (specific command not available in the repository).

## Testing Information

### Testing Framework
The project uses mruby-mtest for testing. Tests are located in the `test` directory.

### Test Configuration
The project uses a separate configuration file for testing located in the `test` directory: `taylor-config.json`:
```json
{
  "name": "taylor-test-suite",
  "version": "v0.0.1",
  "input": "test.rb",
  "export_directory": "./exports",
  "export_targets": [
    "linux",
    "windows",
    "osx/intel",
    "osx/apple",
    "web"
  ],
  "load_paths": [
    "./"
  ],
  "copy_paths": [
    "./assets"
  ],
  "web": {
    "shell_path": "shell.html"
  }
}
```

### Running Tests
To run all tests, use the `run_tests.cmd` script which executes the Taylor framework from the test directory where the configuration file is located:
```
run_tests.cmd
```

Alternatively, you can run tests directly from your IDE using the "Run Tests" run configuration, which executes the same script.

This will run the `test.rb` file located in the test directory, which loads and executes all test files in that directory.

### Writing Tests
1. Create a new test file in the `test` directory with a name ending in `_test.rb`
2. Create a test class that inherits from `MTest::Unit::TestCase`
3. Write test methods that start with `test_`
4. Rememeber - in Mtest we have refute_ matchers - only assert_ can be used
5. For test i we dont use test/taylor-config.json. We jus run taylor and give test.rb as input point (taylor.exe test.rb)

Example:
```ruby
class Test4MTest < MTest::Unit::TestCase
  def test_assert
    assert(true)
    assert(true, 'true sample test')
  end

  def test_assert_block
    assert_block('msg') do
      'something-block'
    end
  end

  def test_assert_empty
    assert_empty('', 'string empty')
    assert_empty([], 'array empty')
    assert_empty({}, 'hash empty')
  end

  def test_assert_equal
    assert_equal('', nil.to_s)
  end

  def test_assert_in_delta
    assert_in_delta(0, 0.1, 0.5)
  end

  def test_assert_includes
    assert_include([1,2,3], 1)
  end

  def test_assert_instance_of
    assert_instance_of Array, []
    assert_instance_of Class, Array
  end

  def test_assert_kind_of
    assert_kind_of Array, []
    assert_kind_of Class, Array
  end

  def test_assert_match
    assert_match 'abc', 'abc'
  end

  def test_skip
    skip 'explain why we skip the test'
  end

  def test_failure
    assert(1 == 0, 'assertion to fail')
  end

  def test_error
    1 + "a"
  end
end
```

### Mocking Game Components
When testing game components, you may need to create mock objects for dependencies. For example, when testing the Grid class, you might need to mock the Vector2 and Unit classes:

```ruby
# Mock Vector2 class for testing
class Vector2
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end

# Mock Unit class for testing
class MockUnit
  attr_accessor :position, :new_position

  def initialize(x, y, passable = true, actionable = false)
    @position = Vector2.new(x, y)
    @new_position = Vector2.new(x, y)
    @passable = passable
    @actionable = actionable
  end

  def passable?
    @passable
  end

  def actionable?
    @actionable
  end
end
```

## Code Style and Development Practices

### Code Style
The project uses RuboCop for code style enforcement. The configuration is in `.rubocop.yml`:

```yaml
require:
  - rubocop-performance

AllCops:
  DisabledByDefault: false
  NewCops: enable
  TargetRubyVersion: 3.2.1
```

To run RuboCop:
```
rubocop
```

### Project Structure
- `rt/`: Core runtime components (Grid, Unit, Event system, etc.)
- `rrrog/`: Game-specific components (Player, enemies, items, etc.)
- `assets/`: Game assets (fonts, sounds, etc.)
- `test/`: Test files
- `saves/`: Save files
- `vendor/`: Third-party libraries

### Game Architecture
The game follows a component-based architecture:
- `RT::Game`: Base game class that manages scenes and events
- `RT::Scene`: Base scene class for different game states (main menu, game)
- `RT::Unit`: Base class for all game entities (player, enemies, items)
- `RT::Grid`: Manages the game grid and unit positions
- `RT::Event`: Event system for communication between components

### Adding New Components
1. For new units (enemies, items, etc.), create a new class that inherits from `RT::Unit`
2. For new scenes, create a new class that inherits from `RT::Scene::Base`
3. Register new components in the appropriate places (e.g., in the Rrrog class for new scenes)

### Debugging
The game includes a debugger that can be enabled in the Rrrog class. Use it to display debug information during development.
