EXCLUSIONS := %.DS_Store %.git% %.gitmodules %~
BASH_DOTFILES := $(filter-out $(EXCLUSIONS), $(wildcard bash/.??*))

.PHONY: list
list: list_bash

.PHONY: list_bash
list_bash:
	@$(foreach val, $(BASH_DOTFILES), /bin/ls -dF $(val);)

.PHONY: deploy
deploy: deploy_bash

.PHONY: deploy_bash
deploy_bash:
	@echo "(deploy bash dotfiles) ---> start "
	@$(foreach F, $(BASH_DOTFILES), ln -sfnv $(abspath $F) $(HOME)/$(notdir $F) 2>&1;)
	@echo "(deploy bash dotfiles) <--- done. "
