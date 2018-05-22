function printHelp {
  write-host "Usage: docker-do [COMMAND] [COMMAND OPTIONS...]"
  write-host ""
  write-host "COMMAND: rebuild - Rebuild container and its image"
  write-host "  $ docker-do rebuild [CONTAINER] [IMAGE] [BUILD-DIR] [CONTAINER-OPTS...] --- [CONTAINER-REST...]"
  write-host ""
  write-host "COMMAND: clean - Delete container and its image"
  write-host "  $ docker-do clean [CONTAINER] [IMAGE]"
  write-host ""
  write-host "COMMAND: publish - Build and publish an image"
  write-host "  $ docker-do publish [IMAGE] [BUILD-DIR] [TAG]"
}

function arrayValues {
  param($direction, $delimiter, [string[]]$values)

  $result = @()
  $current = @() + $values
  $collecting = $direction -eq "before"

  while ($true) {
    if ($current.count -le 0) {
      break
    }

    $first, $rest = $current

    if ($collecting) {
      if ($first -ne $delimiter) {
        $result += $first
      } else {
        break
      }
    } else {
      if ($first -eq $delimiter) {
        $collecting = $true
      }
    }

    $current = $rest
  }

  return $result
}

function runCommand {
  param($command)

  $cmd = $command -replace "\s\s"," "

  write-host "RUN -> $($cmd)"
  Invoke-Expression $cmd
}

function doRebuild {
  param($argValues)

  $container, $restValues = $argValues
  $image, $restValues = $restValues
  $buildDirectory, $restValues = $restValues

  $containerOptions = arrayValues "before" "---" $restValues
  $containerRest = arrayValues "after" "---" $restValues

  write-host "Rebuild:"
  write-host "* Container: $($container)"
  write-host "* Image: $($image)"
  write-host "* Build directory: $($buildDirectory)"
  write-host "* Container options: $($containerOptions)"
  write-host "* Container rest: $($containerRest)"

  runCommand "docker build -t $($image) $($buildDirectory)"
  runCommand "docker stop $($container)"
  runCommand "docker rm $($container)"
  runCommand "docker create --name $($container) $($containerOptions) $image $($containerRest)"
}

function doClean {
  param($argValues)

  $container, $restValues = $argValues
  $image, $restValues = $restValues

  write-host "Clean:"
  write-host "* Container: $($container)"
  write-host "* Image: $($image)"

  runCommand "docker stop $($container)"
  runCommand "docker rm $($container)"
  runCommand "docker rmi $($image)"
}

function doPublish {
  param($argValues)

  $image, $restValues = $argValues
  $buildDirectory, $restValues = $restValues
  $tag, $restValues = $restValues

  write-host "Publish:"
  write-host "* Image: $($image)"
  write-host "* Build directory: $($buildDirectory)"
  write-host "* Tag: $($tag)"

  runCommand "docker build -t $($image) $($buildDirectory)"
  # docker tag $(docker images | grep -e "^$image[[:space:]]\+latest[[:space:]]\+" | awk '{print $3}') $image:$tag
  # docker push $image
}

function global:Docker-Do {
  $cmd, $restArgs = $args;

  if ($cmd -eq "rebuild") {
    doRebuild $restArgs
  } elseif ($cmd -eq "clean") {
    doClean $restArgs
  } elseif ($cmd -eq "publish") {
    doPublish $restArgs
  } else {
    printHelp
  }
}

# docker-do rebuild dev-server nvm C:\Users\billy\Projects\personal\dotpiles -some options -and other --- -also this -and -that
# docker-do clean dev-server nvm
# docker-do publish nvm C:\Users\billy\Projects\personal\dotpiles tagOne
