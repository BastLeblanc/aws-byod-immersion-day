.PHONY: clean

clean:
	rm -rf site

site:
	mkdocs build
	aws s3 sync site/ s3://demos.bastil.cloud/byod/ --delete
