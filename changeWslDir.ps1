$ErrorActionPreference = 'Stop'
# Set-PSDebug -Trace 1

# WSL镜像名称
$wsl_distro = "Ubuntu-24.04"
Write-Host "Target Distro: $wsl_distro"
# 新目录
$base_dir = "D:\wsl"
if (-Not (Test-Path "D:\")) {
    $base_dir = "$HOME\wsl"
}
Write-Host "base_dir: $base_dir"

# 镜像导出目录
$export_dir = "$base_dir\tar"
# 导出镜像路径
$export_fp = "$export_dir\$wsl_distro.tar"
# 新安装位置
$install_location = "$base_dir\$wsl_distro"

if (Test-Path $export_dir) {
    Write-Host "$export_dir 已存在"
}
else {
    # 创建新的目录
    New-Item -Path $export_dir -ItemType Directory -Force
    Write-Host "创建$export_dir 成功"
}

# 关闭WSL
Write-Host "正在关闭 $wsl_distro"
wsl --terminate $wsl_distro
# 列出所有WSL
wsl -l -v

if (Test-Path $export_fp) {
    $use_old_img = Read-Host "发现既存镜像$export_fp。是否使用既存镜像? (y/n)"
    if ($use_old_img -ne "y") {
        exit
    }
}
else {
    # 如果WSL镜像不存在，则导出WSL镜像
    wsl --export $wsl_distro $export_fp
}

# 注销既存的WSL
wsl --unregister $wsl_distro
wsl -l -v

# 导入新的WSL镜像
wsl --import $wsl_distro $install_location $export_fp --version 2
wsl -l -v

# 获取导入对象的Ubuntu命令
$ubuntuCmd = ($wsl_distro -replace '[^a-zA-Z0-9]', '').ToLower()
# 获取镜像中原用户名
$org_user = wsl -d $wsl_distro -- eval "ls /home | grep -v ubuntu"
# 设置原用户为默认用户(不然，默认用户是root)
Invoke-Expression "$ubuntuCmd config --default-user $org_user"

# 启动WSL
wsl -d $wsl_distro --cd ~