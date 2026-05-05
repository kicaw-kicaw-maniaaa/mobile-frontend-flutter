$folders = @(
    ".\lib\core\network",
    ".\lib\core\theme",
    ".\lib\core\routes",
    ".\lib\core\utils",
    ".\lib\core\errors",
    ".\lib\features\auth\presentation\pages",
    ".\lib\features\auth\presentation\bloc",
    ".\lib\features\auth\domain\entities",
    ".\lib\features\auth\domain\repositories",
    ".\lib\features\auth\domain\usecases",
    ".\lib\features\auth\data\models",
    ".\lib\features\auth\data\datasources",
    ".\lib\features\auth\data\repositories",
    ".\lib\features\map\presentation\pages",
    ".\lib\features\reports\presentation\pages",
    ".\lib\features\alerts\presentation\pages"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Force -Path $folder | Out-Null
}
