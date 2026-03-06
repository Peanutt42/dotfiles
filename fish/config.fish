if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting ""

set ANDROID_SDK_ROOT "$HOME/Android/Sdk"
set ANDROID_NDK_ROOT "$HOME/Android/Sdk/ndk/27.0.12077973"
set JAVA_HOME "/usr/lib/jvm/openjdk-21"

set CMAKE_COLOR_DIAGNOSTICS ON
set PATH "/opt/cmake/bin:$PATH"

set PATH "$HOME/.local/bin:$PATH"

# CUDA / NVIDIA
set -gx PATH /usr/local/cuda-12.8/bin $PATH
set -gx LD_LIBRARY_PATH /usr/local/cuda-12.8/lib64 $LD_LIBRARY_PATH
set -gx TRT_PATH /opt/TensorRT-10.13.2.6
set -gx LD_LIBRARY_PATH $TRT_PATH/lib $LD_LIBRARY_PATH
set -gx PATH $TRT_PATH/bin $PATH

# TensorRT
set TENSORRT_ROOT $HOME/Downloads/TensorRT-10.13.2.6.Linux.x86_64-gnu.cuda-12.9/TensorRT-10.13.2.6
set -gx LD_LIBRARY_PATH $TENSORRT_ROOT/lib $LD_LIBRARY_PATH
set -gx CPATH $TENSORRT_ROOT/include $CPATH
set -gx PATH $TENSORRT_ROOT/bin $PATH

# Android Sdk
set -gx NDK_HOME /home/peter/Android/Sdk/ndk/27.0.12077973/

starship init fish | source

zoxide init fish --cmd cd | source


set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/peter/.ghcup/bin # ghcup-env
# Added by Quartus Prime software
export SALT_LICENSE_FILE="$SALT_LICENSE_FILE;/home/peter/.altera.quartus/questa_lic.dat"

# fixes problem with `nix develop` where it runs bash instead of fish
# Solution: replace `nix develop` with `nix develop --command fish`
function nix
    if test (count $argv) -ge 1 -a "$argv[1]" = "develop"
        command nix $argv --command fish
    else
        command nix $argv
    end
end

# opencode
fish_add_path /home/peter/.opencode/bin
