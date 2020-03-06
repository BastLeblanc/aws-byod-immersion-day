.PHONY: clean

clean:
	rm -rf site

site:
	mkdocs build
#	aws s3 rm s3://data-engineering-immersion-day-byod --recursive
#	cd site; aws s3 cp . s3://data-engineering-immersion-day-byod --recursive
