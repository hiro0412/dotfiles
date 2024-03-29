EXCLUSIONS := %.DS_Store %.git% %.gitmodules %~
BASH_DOTFILES := $(filter-out $(EXCLUSIONS), $(wildcard bash/.??*))
DOT_EMACS_DIR := $(HOME)/.emacs.d
EMACS_INITS_ELS := $(filter-out $(EXCLUSIONS), $(wildcard emacs/inits/?*.el))
DDSKK_FILES := $(filter-out $(EXCLUSIONS), $(wildcard emacs/ddskk/?*))
GIT_DOTFILES := $(filter-out $(EXCLUSIONS), $(wildcard git/.??*))

.PHONY: list
list: list_bash

.PHONY: list_bash
list_bash:
	@$(foreach val, $(BASH_DOTFILES), /bin/ls -dF $(val);)

#.PHONY: list_emacs
#list_emacs:
#	@$(foreach val, $(EMACS_DOTFILES), /bin/ls -dF $(val);)

.PHONY: list_git
list_git:
	@$(foreach val, $(GIT_DOTFILES), /bin/ls -dF $(val);)

.PHONY: deploy
deploy: deploy_bash

.PHONY: deploy_bash
deploy_bash:
	@echo "(deploy bash dotfiles) ---> start "
	@$(foreach F, $(BASH_DOTFILES), ln -sfnv $(abspath $F) $(HOME)/$(notdir $F) 2>&1;)
	@echo "(deploy bash dotfiles) <--- done. "

.PHONY: deploy_emacs
deploy_emacs:
	@echo "(deploy emacs dotfiles) ---> start "
	mkdir -p $(DOT_EMACS_DIR)
	@ln -sfnv $(abspath emacs/init.el) $(DOT_EMACS_DIR)/init.el 2>&1
	mkdir -p $(DOT_EMACS_DIR)/ddskk
	@$(foreach F, $(DDSKK_FILES), ln -sfnv $(abspath $F) $(DOT_EMACS_DIR)/ddskk/$(notdir $F) 2>&1;)
	@echo "(deploy emacs dotfiles) <--- done. "

.PHONY: deploy_git
deploy_git:
	@echo "(deploy git dotfiles) ---> start "
	@$(foreach F, $(GIT_DOTFILES), ln -sfnv $(abspath $F) $(HOME)/$(notdir $F) 2>&1;)
	@echo "(deploy git dotfiles) <--- done. "
