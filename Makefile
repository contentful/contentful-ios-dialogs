.PHONY: lint

# more readable output in lieu of warnings from the dependencies
lint:
	@pod lib lint --use-libraries --allow-warnings \
		--sources=https://github.com/CocoaPods/Specs.git,https://github.com/contentful/CocoaPodsSpecs \
		2>&1|grep -v 'AFNetworking\|TSMiniWebBrowser\|Unable to load\|UIKit\|cmark\|CocoaMarkdown\|Ono\|interfaceOrientation'

