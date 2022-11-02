### Preparing the image
```sh
docker build -t aas-image .
```

### Run the container
```sh
# Run once
docker run -p 3000:3000 -p 8000:8000 -p 4841 --rm -it aas-image
# Run in the background
docker run -p 3000:3000 -p 8000:8000 -p 4841 --name aas aas-image
```
