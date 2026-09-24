# Usage
## Activate Ruby

```sh
rvm use 3.2.2
```

## Verify Ruby Version

```sh
ruby -v
```

## Run Simulator

### With Input From File

```sh
./bin/simulator fixtures/basic_movement.txt
```

### With Standard Input

```sh
echo "PLACE 0,0,NORTH\nREPORT" | ./bin/simulator
```
