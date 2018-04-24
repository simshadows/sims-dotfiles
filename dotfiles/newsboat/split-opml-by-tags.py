#!/usr/bin/env python3

import os
import sys
import shutil
import collections
import re

# Reserved tags
NO_TAGS_TAG = "NO-TAGS"
ORIGINAL_TAG = "ORIGINAL"

src_dir = sys.argv[1] # Good enough arg parsing for now

# We read these:
orig = os.path.join(src_dir, "autogenerated-opml/ORIGINAL.xml")
urls = os.path.join(src_dir, ".newsboat/urls")
# And we write our OPML files to here:
dumpto = os.path.join(src_dir, "autogenerated-opml")

print("    Reading tags...")

# Populate collections of feeds with particular tags
# tags[<tag-name>] = {<feed-url-1>, <feed-url-2>, ...}
tags = collections.defaultdict(set)
no_tags = set()
all_urls = set()
with open(urls, "r") as f:
    for line in f:
        line = line.strip()
        if len(line) == 0:
            continue
        assert line.startswith("http")
        substr1 = line.split(maxsplit=1)
        substr1[0] = substr1[0].replace("&", "&amp;") # A HACK.............
        assert substr1[0] not in all_urls
        all_urls.add(substr1[0])
        if len(substr1) == 1:
            no_tags.add(substr1[0])
        elif len(substr1) == 2:
            # The .split() op below on:
            #   "some tag1" "some tag2"
            # would return something like:
            #   ['', 'some tag1', ' ', 'some tag2', '']
            skip = True # Skip when empty string expected
            has_tags = False
            for s in substr1[1].split("\""):
                s = s.strip()
                assert (skip and len(s) == 0) or (not skip and len(s) > 0)
                if not skip and not s.startswith("~"):
                    s = s.replace(" ", "-").replace("_", "-").lower()
                    s = re.sub(r'[^a-z0-9-]+', '', s)
                    assert(len(s) > 0)
                    tags[s].add(substr1[0])
                    has_tags = True
                skip = not skip
            assert not skip # We should finish on an empty string
            if not has_tags:
                no_tags.add(substr1[0])
        else:
            raise ValueError
# Sanity check on the set union
assert no_tags.union(*tags.values()) == all_urls
print("    URLs found: {}".format(len(all_urls)))

assert (NO_TAGS_TAG not in tags) and (ORIGINAL_TAG not in tags) # Reserved words
if len(no_tags) > 0:
    tags[NO_TAGS_TAG] = no_tags

# Feedback on set sizes
print("    Tags found:")
for k, v in tags.items():
    assert len(v) > 0
    print("        '{}' with {} URLs.".format(k, len(v)))

# Create the new OPML files
print("    Writing new OPML files...")
with open(orig, "r") as orig_f:
    for tag, urls_to_keep in tags.items():
        newopml = os.path.join(dumpto, tag + ".xml")
        urls_to_remove = all_urls - urls_to_keep
        orig_f.seek(0)
        print("        {}".format(newopml))
        with open(newopml, "w") as new_f:
            for line in orig_f:
                if all(("xmlUrl=\"{}\"".format(x) not in line) for x in urls_to_remove):
                    new_f.write(line)
    
