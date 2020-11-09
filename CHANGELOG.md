# 1.3.0

BREAKING:

* Requires terraform >= 0.13
* Updated mediapop/route53-alias/aws to 1.2.0 which will cause DNS records to be recreated.

# 1.2.1

BUG FIXES:

* Truncate the bucket name to fit the S3 name limit.

# 1.2.0

FEATURES:

* Always setup https redirects from `redirect_to`

ENHANCEMENTS:

* Use the bucket prefix to always generate a unique bucket.

BUG FIXES:

* Fix HTTPS failing to connect to the redirect bucket.

# 1.1.0

FEATURES:

* Allow passing an empty domain map.

# 1.0.1

BUG FIXES:

* The readme now points to the registry source.

# 1.0

Initial release.
