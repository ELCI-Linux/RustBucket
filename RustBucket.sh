#! /bin/bash/

	helper="RustBucket"
	versnum="1.0"

	zenity --notification --text="RustBucket"


	bucket=$(zenity --list --checklist \
	--title="$helper $versnum" \
	--height=300 \
	--text="Select the rust software you would like to install" \
	--column="Selected"	--column="Rust Software" \
			""			"bat" \
			""			"exa" \
			""			"fd" \
			""			"procs" \
			""			"ripgrep" \
			""			"starship prompt" \
			""			"tokei")


	BAT=$(echo $bucket | grep -c "bat")
	EXA=$(echo $bucket | grep -c "exa")
	FD=$(echo $bucket | grep -c "fd")
	PROCS=$(echo $bucket | grep -c "procs")
	RIPGREP=$(echo $bucket | grep -c "ripgrep")
	SSP=$(echo $bucket | grep -c "starship")
	TOK=$(echo $bucket | grep -c "tokei")

	zenity --notification --text="Installing cargo"
	pkexec apt-get install -y cargo

	if [ $BAT -gt "0" ]; then
	zenity --notification --text="Installing bat"
	cargo install bat
	fi

	if [ $EXA -gt "0" ]; then
	zenity --notification --text="Installing exa"
	cargo install exa
	fi

	if [ $FD -gt "0" ]; then
	zenity --notification --text="Installing fd"
	cargo install fd
	fi

	if [ $PROCS -gt "0" ]; then
	zenity --notification --text="Installing procs"
	cargo install procs
	fi

	if [ $RIPGREP -gt "0" ]; then
	zenity --notification --text="Installing ripgrep"
	cargo install rg
	fi

	if [ $SSP -gt "0" ]; then
	zenity --notification --text="Installing Starship prompt"
	zenity --notification --text="Complete installation via the terminal"
	
		sh -c "$(curl -fsSL https://starship.rs/install.sh)"
		
	SHELL=$(zenity --list --checklist \
		--title="$helper $versnum: Starship Prompt" \
		--text="Select the shells you wish to run Starship Prompt in" \
		--column="Selected"	--column="Shells" \
				""		"bash" \
				""		"fish" \
				""		"zsh")


	BASH=$(cat $SHELL | grep -c "bash")
	FISH=$(cat $SHELL | grep -c "fish")
	ZSH=$(cat $SHELL | grep -c "zsh")


		if [ ${#SHELL} -eq "0" ]; then
		exit
		elif [ ${#SHELL} -gt "1" ]; then
			if [ $BASH -gt "0" ]; then
			pkexec echo "#Starship Prompt" >> ~/.bashrc
			pkexec echo 'eval "$(starship init bash)"' >> ~/.bashrc && \
			zenity --notification --text="Starship is now available via bash"
			fi

			if [ $FISH -gt "0" ]; then
			pkexec echo "#Starship Prompt" >> ~/.config/fish/config.fish
			pkexec echo 'starship init fish | source' >> ~/.config/fish/config.fish && \
			zenity --notification --text="Starship is now available via fish"
			fi

			if [ $ZSH -gt "0" ]; then
			pkexec echo "#Starship Prompt" >> ~/.zshrc && \
			pkexec echo 'eval "$(starship init zsh)"' >> ~/.zshrc && \
			zenity --notification --text="Starship is now available via zsh" || \
			zenity --notificaiton --text="Warning, an error occured adding eval to ~/.zshrc"
			fi
		else
			zenity --notification --text="Manually enable shells to use startship"

		fi

			zenity --notifcation --text="Starship installation complete"
			#Post-install configure
			zenity --question \
			--title="$helper $vernsum" \
			--width=500 \
			--text="Would you like to configure starship prompt/"

			if [ $? -eq "0" ]; then
			mkdir -p ~/.config && touch ~/.config/starship.toml
			else
			zenity --notification --text="Visit starship.rs for details on configuration"
			fi
	fi

	if [ $TOK -gt "0" ]; then
	zenity --notification --text="Tokei"
	cargo install tokei && \
	zenity --notification --text="Tokei installed" || \
	zenity --notification --text="Tokei could not be installed"
	fi
