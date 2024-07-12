# Player Music

## Sobre o Projeto

O Projeto de Play Music foi desenvolvido com intuito de aprimorar os meus conhecimentos sobre o Flutter e a plataforma Android. È um aplicativo simples que permite aos usuários reproduzir músicas armazenadas localmente em seus dispositivos. Ele oferece funcionalidades como controle de reprodução, pesquisa de arquivos de áudio, gerenciamento de permissões e com uma interface de usuário simples. O projeto utiliza um padrão de arquitetura **MVC** e tambem várias bibliotecas para fornecer uma experiência completa e eficiente.


## Pacotes Utilizados no projeto

### just_audio:

Descrição: Uma biblioteca poderosa para reprodução de áudio que suporta uma variedade de formatos e oferece controle avançado sobre a reprodução.

Uso: Reproduzir, pausar, parar e controlar a reprodução de arquivos de áudio.

### on_audio_query:

Descrição: Fornece uma API para consultar arquivos de áudio armazenados localmente no dispositivo.

Uso: Obter a lista de músicas disponíveis no dispositivo do usuário.

### flutter_modular:

Descrição: Um gerenciador de rotas e injeção de dependências para Flutter.

Uso: Estruturar o projeto de forma modular e gerenciar a navegação e injeção de dependências.

### audio_session:

Descrição: Gerencia sessões de áudio e suas configurações.

Uso: Configurar e gerenciar sessões de áudio para garantir a reprodução correta e eficiente.

### carousel_slider:

Descrição: Um widget de carrossel de imagens e conteúdos.

Uso: Criar um carrossel de músicas na interface do usuário.

### shared_preferences:

Descrição: Fornece uma maneira simples de armazenar dados persistentes de maneira chave-valor.

Uso: Salvar as preferências do usuário, como tema e última música reproduzida.

### equatable:

Descrição: Simplifica a comparação de objetos para verificar igualdade.

Uso: Usado para criar modelos de dados que podem ser facilmente comparados.

### path_provider:

Descrição: Fornece caminhos para diretórios comumente usados no sistema de arquivos.

Uso: Obter o caminho para o diretório de músicas no dispositivo.

### audio_video_progress_bar:

Descrição: Um widget para exibir uma barra de progresso de áudio/vídeo.

Uso: Mostrar o progresso da reprodução de áudio.

### audio_service:

Descrição: Fornece suporte para controle de mídia de fundo e serviços de áudio.

Uso: Gerenciar a reprodução de áudio em segundo plano.

### permission_handler:

Descrição: Gerencia permissões de runtime para aplicativos.

Uso: Solicitar e verificar permissões necessárias para acessar arquivos de áudio no dispositivo.

### rx_dart:

Descrição: Um conjunto de operadores para programação reativa com Dart.

Uso: Gerenciar streams e eventos reativos no aplicativo.

## Enviando Áudios para o Emulador

Para testar a reprodução de músicas no emulador, você precisa enviar arquivos de áudio para o emulador.
 Certifique-se de que você tem os arquivos de áudio prontos em uma pasta no seu computador. Se não tiver, vai na pasta do projeto e acesse a pasta `assets/audios`.

Depois de cetificar os áudios, inicializa o emulador e envia os arquivos arrastando-los encima do emulador, essa é a abordagem mais simples para enviar arquivos. A outra abordagem é abrir o Android Studio, vá para `AVD Manager` e inicie o emulador desejado. Depois de inicializar vá para `View > Tool Windows > Device File Explorer` e navegue até o diretótio `/sdcard`. Clique com o botão direito na pasta e selecione **Upload**.
Escolha os arquivos de áudio do seu computador e faça o upload para o diretório selecionado no emulador.

<p>
<img src="assets/md/play_music.gif" alt="gif player de músicas" width="360", height="720"/>
</p>
