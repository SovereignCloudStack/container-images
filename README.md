# container-images
Container images collection


# Upgrade Images
Here is described how to upgrade an image, the example will be the `scs-keycloak` image.

1. In the first place, the contributor has to modify the `Containerfile` inside the image folder.

2. Then, go to `.github/workflows/build-keycloak-container-image.yml` and modify the version for Keycloak.
   in this case is on line [26](https://github.com/SovereignCloudStack/container-images/blob/main/.github/workflows/build-keycloak-container-image.yml#L26).

3. After the merge request is successfully merged, the CI in the repo will build and push the new image to the docker registry.

Each day, the CI will rebuild the image and upload it again to keep it update in case of hotfixes.


# Important
For the Keycloak image, the `home-IdP-discovery` plugging is added in the Dockerfile, it is important to check in in case of major version upgrades, that the plugging works and it's in the correct version.

