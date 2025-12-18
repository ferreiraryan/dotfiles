# Add user configurations here
# For HyDE to not touch your beloved configurations,
# we added 2 files to the project structure:
# 1. ~/.hyde.zshrc - for customizing the shell related hyde configurations
# 2. ~/.zshenv - for updating the zsh environment variables handled by HyDE // this will be modified across updates

#  Plugins 
# oh-my-zsh plugins are loaded  in ~/.hyde.zshrc file, see the file for more information

#  Aliases 
# Add aliases here

#  This is your file 
# Add your configurations here

# Mostrar nome da venv no prompt se estiver ativada

# # Atenção aqui:
# # Seu prompt original está intacto, só adiciona o VENV antes.
# PROMPT='${VENV}'"${PROMPT_ORIGINAL:-$PROMPT}"
# PROMPT_ORIGINAL=$PROMPT
# export PATH="$HOME/flutter/bin:$PATH"
#
export CHROME_EXECUTABLE=$(which chromium)
export PATH="$PATH":"$HOME/.pub-cache/bin"
# export ANDROID_SDK_ROOT=/opt/android-sdk
# export ANDROID_HOME=$ANDROID_SDK_ROOT
# export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
# export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools
#
# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
# export PATH=$JAVA_HOME/bin:$PATH
# # Configuração do Pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
#
# alias pact="source \$(poetry env info --path)/bin/activate"
#
if [ -f ~/.zsh/docker-aliases.zsh ]; then
  source ~/.zsh/docker-aliases.zsh
fi


# --- Configurações de Desenvolvimento ---

# Flutter
export PATH="$HOME/flutter/bin:$PATH"

# Java
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"
export PATH="$JAVA_HOME/bin:$PATH"

# Android SDK
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export ANDROID_HOME="$ANDROID_SDK_ROOT" # Para compatibilidade
# export ANDROID_AVD_HOME="/.android/avd" # AVDs no SSD
export ANDROID_AVD_HOME="$HOME/.config/.android/avd"

# Adiciona as ferramentas do SDK ao PATH na ordem correta
# Removido o /tools/ obsoleto
export PATH="$ANDROID_SDK_ROOT/emulator:$PATH"
export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH"

# Dart e Pub
export PATH="$PATH:$HOME/.pub-cache/bin"
export CHROME_EXECUTABLE=$(which chromium)

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Alias
alias pact="source \$(poetry env info --path)/bin/activate"


alias emupixel='QT_QPA_PLATFORM=xcb emulator -avd Pixel_7_API_34 -gpu swiftshader_indirect -no-snapshot-load &'

export PATH="$HOME/.local/bin:$PATH"
