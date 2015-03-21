all:
	true

regen: regen-fetchers

regen-fetchers:
	python3 -c '\
			import json, emonoda.plugins; \
			print(json.dumps({ \
				item.get_name(): { \
					"version": item.get_version(), \
					"fingerprint": item.get_fingerprint(), \
				} \
				for item in emonoda.plugins._get_classes()["fetchers"].values() \
			}, sort_keys=True, indent=" " * 4)) \
		' > fetchers.json

pypi:
	python setup.py register
	python setup.py sdist upload

clean:
	rm -rf build dist *.egg-info
	find -name __pycache__ | xargs rm -rf

clean-all: clean
	rm -rf .tox
