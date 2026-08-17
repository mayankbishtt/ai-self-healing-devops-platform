$files = Get-ChildItem ".\k8s\*.yaml"

foreach ($file in $files) {
    $relativePath = $file.FullName.Substring((Get-Location).Path.Length + 1)
    $containerPath = "/workdir/" + $relativePath.Replace("\", "/")

    docker run --rm `
        -v "${PWD}:/workdir" `
        ghcr.io/yannh/kubeconform:latest `
        -strict `
        -summary `
        $containerPath

    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }
}