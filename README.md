> A Boggle Game API !

<p align="center">
    <img src="public/images/boggle-logo.png" height="150"><br>
    <a href="https://github.com/imskr/boggle-api/releases"><img alt="GitHub release (latest by date including pre-releases)" src="https://img.shields.io/github/v/release/imskr/boggle-api?include_prereleases&style=flat-square"></a>
    <a href="https://github.com/imskr/Rusty-Skywalker/issues"><img alt="Github Issues" src="https://img.shields.io/github/issues/imskr/boggle-api?color=orange&style=flat-square"></a>
</p>
<hr noshade>

## Local Setup

*Make Sure the docker and docker-compose is installed on your local Machine. [Click Here](https://docs.docker.com/install/) to know that how to install Docker*.

- **Docker:**

  ```bash
  $ git clone https://github.com/imskr/boggle-api.git
  $ cd boggle-api
  $ docker-compose run web rake db:create db:migrate
  $ docker-compose up
  ```

  - The server is up and running at `http://localhost:3000`
