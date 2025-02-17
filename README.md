# Quick Start
## Requirements
- Docker Desktop/Docker Engine v23.0 or later (The Dockerfile uses BuildKit)

## Set Up (using Docker Compose)
1. Git clone this repo
```bash
git clone git@github.com:tehwenyi/label-studio.git
```
2. Change directory
```bash
cd label-studio
```
3. Run Docker Compose
```bash
docker compose up
```

## Set Up (using Docker)
1. Git clone this repo
```bash
git clone git@github.com:tehwenyi/label-studio.git
```
2. Change directory
```bash
cd label-studio
```
3. Build a local image using this repo's Dockerfile:
```bash
docker build -t heartexlabs/label-studio:latest .
```
4. Run the Docker image in debug mode
```bash
docker run -it -p 8080:8080 -v $(pwd)/mydata:/label-studio/data heartexlabs/label-studio:latest label-studio --log-level DEBUG
```

5. If you run into a PermissionError ([Link to issue](https://github.com/heartexlabs/label-studio/issues/3465)), `PermissionError: [Errno 13] Permission denied: '/label-studio/data/media'`, please run the following code in your terminal to make your mount data writable:
```bash
sudo chmod -R 777 mydata/
```
Then, run Step 4 again

6. Upon a successful set up, you should see the following running:

<img src="images/quickstart/server_running_eg.png">


## Usage
1. Open any browser and access Label Studio at `http://localhost:8080`
2. Sign up/log in
3. Create your Project
    * Indicate project name & description
    * Import all your images (Note: The `Data Import` portion may lag. Be patient (:)
    * Set up your labelling experience
4. Start Annotating
5. Export Annotations (COCO format is preferred)

## Annotate using Pre-annotations via Local Storage

If you have a `predictions.json` COCO annotations file from a model that you'd like to use as pre-annotations, you can do so.

1. Set environment variables so that you can access local storage

   - **Option 1**: If using the `label-studio` package, add these variables to your environment setup:

     ```bash
     export LABEL_STUDIO_LOCAL_FILES_SERVING_ENABLED=1
     export LABEL_STUDIO_LOCAL_FILES_DOCUMENT_ROOT=/home/user
     ```
     
     OR for Windows (not tested on Windows):
     
     ```bash
     export LABEL_STUDIO_LOCAL_FILES_SERVING_ENABLED=1
     export LABEL_STUDIO_LOCAL_FILES_DOCUMENT_ROOT=C:\\data\\media
     ```

   - **Option 2**: If using Docker, edit the variables and run the bash script:
   
     ```bash
     sh run_docker_preannotations.sh
     ```

2. Convert your COCO annotation file to the Label Studio Format

   Refer to Quick Start in [Label Studio Converter](https://github.com/tehwenyi/label-studio-converter). 
   
   Verify that you have 2 files: `your_output.json` and an `output.label_config.xml`

3. Open Label Studio in your web browser.

4. Add your Configuration.

   - Create your Project. Under Labeling Setup, put your XML into the Code.
   
     Example picture:
     ![Preannotations Labeling](images/screenshots/preannotations_labeling.png)

5. Import your converted `your_output.json` file into your Project.

     ![Preannotations Import](images/screenshots/preannotations_import-button.png)

6. Add Local Storage.

   - For a specific project, open **Settings > Cloud Storage**

   - Click **Add Source Storage**

   - Change Storage Type to **Local Files**

   - If your folder directory is like this:

     ```
     parent_directory/
     └── images/
         ├── image1.jpg
         ├── image2.png
         ├── image3.jpeg
         └── ...
     ```

     Add `/label-studio/files/images` to absolute local path

     Example image:
     ![Preannotations Local Storage](images/screenshots/preannotations_local-storage.png)

   - Make sure the checkbox is unchecked. Also do NOT sync storage.

   - Make sure you perform this step AFTER importing the JSON file.

7. Return to your Project. Start annotating.

For general pre-annotations instructions, you can refer to [Label Studio Predictions](https://labelstud.io/guide/predictions).

In case you encounter any issues with Local Storage, you may refer to [Label Studio Storage Guide](https://labelstud.io/guide/storage#Local-storage), [GitHub Issue 1](https://github.com/HumanSignal/label-studio/issues/774), or [GitHub Issue 2](https://github.com/HumanSignal/label-studio/issues/2086).

## Important Notes
- If using multiple devices for annotation: 
  * Difficult to import incomplete annotations into another device for annotation. 
  * Recommended to split and allocate images to each device beforehand and combining the dataset again after exporting.
- If you want to add a pre-trained model:
  * You can use MMDetection. [Link to instructions](https://labelstud.io/tutorials/object-detector.html)


## Changes (from original repo)
- Increased maximum dataset size (250MB --> 100GB).The value (in Bytes) can be changed in `Line 80` of [`Dockerfile`](/Dockerfile), under ENV variable `DATA_UPLOAD_MAX_MEMORY_SIZE`
- Fixed a bug in `label-studio/label_studio/data_import/uploader.py`. [Link to issue](https://github.com/heartexlabs/label-studio/issues/4081)

# Original Repo's README
<img src="https://user-images.githubusercontent.com/12534576/192582340-4c9e4401-1fe6-4dbb-95bb-fdbba5493f61.png"/>

![GitHub](https://img.shields.io/github/license/heartexlabs/label-studio?logo=heartex) ![label-studio:build](https://github.com/heartexlabs/label-studio/workflows/label-studio:build/badge.svg) ![GitHub release](https://img.shields.io/github/v/release/heartexlabs/label-studio?include_prereleases)

[Website](https://labelstud.io/) • [Docs](https://labelstud.io/guide/) • [Twitter](https://twitter.com/labelstudiohq) • [Join Slack Community <img src="https://app.heartex.ai/docs/images/slack-mini.png" width="18px"/>](https://slack.labelstud.io/?source=github-1)


## What is Label Studio?

<!-- <a href="https://labelstud.io/blog/release-130.html"><img src="https://github.com/heartexlabs/label-studio/raw/master/docs/themes/htx/source/images/release-130/LS-Hits-v1.3.png" align="right" /></a> -->

Label Studio is an open source data labeling tool. It lets you label data types like audio, text, images, videos, and time series with a simple and straightforward UI and export to various model formats. It can be used to prepare raw data or improve existing training data to get more accurate ML models.

- [Try out Label Studio](#try-out-label-studio)
- [What you get from Label Studio](#what-you-get-from-label-studio)
- [Included templates for labeling data in Label Studio](#included-templates-for-labeling-data-in-label-studio)
- [Set up machine learning models with Label Studio](#set-up-machine-learning-models-with-Label-Studio)
- [Integrate Label Studio with your existing tools](#integrate-label-studio-with-your-existing-tools)

![Gif of Label Studio annotating different types of data](https://raw.githubusercontent.com/heartexlabs/label-studio/master/images/annotation_examples.gif)

Have a custom dataset? You can customize Label Studio to fit your needs. Read an [introductory blog post](https://towardsdatascience.com/introducing-label-studio-a-swiss-army-knife-of-data-labeling-140c1be92881) to learn more. 

## Try out Label Studio

Install Label Studio locally, or deploy it in a cloud instance. [Or, sign up for a free trial of our Enterprise edition.](https://heartex.com/free-trial).

- [Install locally with Docker](#install-locally-with-docker)
- [Run with Docker Compose (Label Studio + Nginx + PostgreSQL)](#run-with-docker-compose)
- [Install locally with pip](#install-locally-with-pip)
- [Install locally with Anaconda](#install-locally-with-anaconda)
- [Install for local development](#install-for-local-development)
- [Deploy in a cloud instance](#deploy-in-a-cloud-instance)

### Install locally with Docker
Official Label Studio docker image is [here](https://hub.docker.com/r/heartexlabs/label-studio) and it can be downloaded with `docker pull`. 
Run Label Studio in a Docker container and access it at `http://localhost:8080`.


```bash
docker pull heartexlabs/label-studio:latest
docker run -it -p 8080:8080 -v $(pwd)/mydata:/label-studio/data heartexlabs/label-studio:latest
```
You can find all the generated assets, including SQLite3 database storage `label_studio.sqlite3` and uploaded files, in the `./mydata` directory.

#### Override default Docker install
You can override the default launch command by appending the new arguments:
```bash
docker run -it -p 8080:8080 -v $(pwd)/mydata:/label-studio/data heartexlabs/label-studio:latest label-studio --log-level DEBUG
```

#### Build a local image with Docker
If you want to build a local image, run:
```bash
docker build -t heartexlabs/label-studio:latest .
```

### Run with Docker Compose
Docker Compose script provides production-ready stack consisting of the following components:

- Label Studio
- [Nginx](https://www.nginx.com/) - proxy web server used to load various static data, including uploaded audio, images, etc.
- [PostgreSQL](https://www.postgresql.org/) - production-ready database that replaces less performant SQLite3.

To start using the app from `http://localhost` run this command:
```bash
docker-compose up
```

### Run with Docker Compose + MinIO
You can also run it with an additional MinIO server for local S3 storage. This is particularly useful when you want to 
test the behavior with S3 storage on your local system. To start Label Studio in this way, you need to run the following command:
````bash
# Add sudo on Linux if you are not a member of the docker group
docker compose -f docker-compose.yml -f docker-compose.minio.yml up -d
````
If you do not have a static IP address, you must create an entry in your hosts file so that both Label Studio and your 
browser can access the MinIO server. For more detailed instructions, please refer to [our guide on storing data](docs/source/guide/storedata.md).


### Install locally with pip

```bash
# Requires Python >=3.8
pip install label-studio

# Start the server at http://localhost:8080
label-studio
```

### Install locally with Anaconda

```bash
conda create --name label-studio
conda activate label-studio
conda install psycopg2
pip install label-studio
```

### Install for local development

You can run the latest Label Studio version locally without installing the package with pip. 

```bash
# Install all package dependencies
pip install -e .
# Run database migrations
python label_studio/manage.py migrate
python label_studio/manage.py collectstatic
# Start the server in development mode at http://localhost:8080
python label_studio/manage.py runserver
```

### Deploy in a cloud instance

You can deploy Label Studio with one click in Heroku, Microsoft Azure, or Google Cloud Platform: 

[<img src="https://www.herokucdn.com/deploy/button.svg" height="30px">](https://heroku.com/deploy?template=https://github.com/heartexlabs/label-studio/tree/heroku-persistent-pg)
[<img src="https://aka.ms/deploytoazurebutton" height="30px">](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fheartexlabs%2Flabel-studio%2Fmaster%2Fazuredeploy.json)
[<img src="https://deploy.cloud.run/button.svg" height="30px">](https://deploy.cloud.run)


#### Apply frontend changes

The frontend part of Label Studio app lies in the `frontend/` folder and written in React JSX. In case you've made some changes there, the following commands should be run before building / starting the instance:

```
cd label_studio/frontend/
yarn install --frozen-lockfile
npx webpack
cd ../..
python label_studio/manage.py collectstatic --no-input
```

### Troubleshoot installation
If you see any errors during installation, try to rerun the installation

```bash
pip install --ignore-installed label-studio
```

#### Install dependencies on Windows 
To run Label Studio on Windows, download and install the following wheel packages from [Gohlke builds](https://www.lfd.uci.edu/~gohlke/pythonlibs) to ensure you're using the correct version of Python:
- [lxml](https://www.lfd.uci.edu/~gohlke/pythonlibs/#lxml)

```bash
# Upgrade pip 
pip install -U pip

# If you're running Win64 with Python 3.8, install the packages downloaded from Gohlke:
pip install lxml‑4.5.0‑cp38‑cp38‑win_amd64.whl

# Install label studio
pip install label-studio
```

### Run test suite
To add the tests' dependencies to your local install:

```bash
pip install -r deploy/requirements-test.txt
```

Alternatively, it is possible to run the unit tests from a Docker container in which the test dependencies are installed:


```bash
make build-testing-image
make docker-testing-shell
```

In either case, to run the unit tests:

```bash
cd label_studio

# sqlite3
DJANGO_DB=sqlite DJANGO_SETTINGS_MODULE=core.settings.label_studio pytest -vv

# postgres (assumes default postgres user,db,pass. Will not work in Docker
# testing container without additional configuration)
DJANGO_DB=default DJANGO_SETTINGS_MODULE=core.settings.label_studio pytest -vv
```


## What you get from Label Studio

![Screenshot of Label Studio data manager grid view with images](https://raw.githubusercontent.com/heartexlabs/label-studio/master/images/labelstudio-ui.gif)

- **Multi-user labeling** sign up and login, when you create an annotation it's tied to your account.
- **Multiple projects** to work on all your datasets in one instance.
- **Streamlined design** helps you focus on your task, not how to use the software.
- **Configurable label formats** let you customize the visual interface to meet your specific labeling needs.
- **Support for multiple data types** including images, audio, text, HTML, time-series, and video. 
- **Import from files or from cloud storage** in Amazon AWS S3, Google Cloud Storage, or JSON, CSV, TSV, RAR, and ZIP archives. 
- **Integration with machine learning models** so that you can visualize and compare predictions from different models and perform pre-labeling.
- **Embed it in your data pipeline** REST API makes it easy to make it a part of your pipeline

## Included templates for labeling data in Label Studio 

Label Studio includes a variety of templates to help you label your data, or you can create your own using specifically designed configuration language. The most common templates and use cases for labeling include the following cases:

<img src="https://raw.githubusercontent.com/heartexlabs/label-studio/master/images/templates-categories.jpg" />

## Set up machine learning models with Label Studio

Connect your favorite machine learning model using the Label Studio Machine Learning SDK. Follow these steps:

1. Start your own machine learning backend server. See [more detailed instructions](https://github.com/heartexlabs/label-studio-ml-backend).
2. Connect Label Studio to the server on the model page found in project settings.

This lets you:

- **Pre-label** your data using model predictions. 
- Do **online learning** and retrain your model while new annotations are being created. 
- Do **active learning** by labeling only the most complex examples in your data.

## Integrate Label Studio with your existing tools

You can use Label Studio as an independent part of your machine learning workflow or integrate the frontend or backend into your existing tools.  

* Use the [Label Studio Frontend](https://github.com/heartexlabs/label-studio-frontend) as a separate React library. See more in the [Frontend Library documentation](https://labelstud.io/guide/frontend.html). 

## Ecosystem

| Project | Description |
|-|-|
| label-studio | Server, distributed as a pip package |
| [label-studio-frontend](https://github.com/heartexlabs/label-studio-frontend) | React and JavaScript frontend and can run standalone in a web browser or be embedded into your application. |  
| [data-manager](https://github.com/heartexlabs/dm2) | React and JavaScript frontend for managing data. Includes the Label Studio Frontend. Relies on the label-studio server or a custom backend with the expected API methods. | 
| [label-studio-converter](https://github.com/heartexlabs/label-studio-converter) | Encode labels in the format of your favorite machine learning library | 
| [label-studio-transformers](https://github.com/heartexlabs/label-studio-transformers) | Transformers library connected and configured for use with Label Studio |


## Roadmap

Want to use **The Coolest Feature X** but Label Studio doesn't support it? Check out [our public roadmap](roadmap.md)!

## Citation

```tex
@misc{Label Studio,
  title={{Label Studio}: Data labeling software},
  url={https://github.com/heartexlabs/label-studio},
  note={Open source software available from https://github.com/heartexlabs/label-studio},
  author={
    Maxim Tkachenko and
    Mikhail Malyuk and
    Andrey Holmanyuk and
    Nikolai Liubimov},
  year={2020-2022},
}
```

## License

This software is licensed under the [Apache 2.0 LICENSE](/LICENSE) © [Heartex](https://www.heartex.com/). 2020-2022

<img src="https://user-images.githubusercontent.com/12534576/192582529-cf628f58-abc5-479b-a0d4-8a3542a4b35e.png" title="Hey everyone!" width="180" />
