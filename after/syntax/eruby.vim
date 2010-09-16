" YAML Metadata blocks (Webby)
unlet b:current_syntax
syn include @yamlMetadata syntax/yaml.vim 

syn region embeddedYaml start="^---$" end="^---\n" keepend contains=@yamlMetadata