# PowerShell Scripts

Coletânea de Scripts para atividades do dia-a-dia.

## CreateWebUsingCustomTemplate.ps1

Esse script cria uma novo subsite (Web) utilizando um custom Web Template.

### Como rodar
Esse script recebe os parâmetros abaixo:
- Url [site collection url] 
- WebUrl [url do novo site] 
- WebTitle [Titulo do Site] 
- WebDescription [Descrição do Site]  
- TemplateType [Nome do template .WSP] 
- LanguageID [LCID do Site - 1046 para sites em Português]

```PowerShell
#Exemplo
.\CreateWebUsingTemplate.ps1 -Url http://dev -WebUrl /dev/Test -WebTitle "Novo Site" -WebDescription "Descricao do Site"  -TemplateType "Meu-Site-TEmplate.wsp" -LanguageID 1046
```
