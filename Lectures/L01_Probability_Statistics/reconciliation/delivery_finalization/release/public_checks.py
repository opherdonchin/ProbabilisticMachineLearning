import concurrent.futures
import datetime
import hashlib
import json
from pathlib import Path
import urllib.request
import urllib.error

OUT = Path('/tmp/l01-release-readiness')
PIN = '7304c542dd1b0bfd6762ea08d2cb384ffd7d2e39'
BASE = 'https://raw.githubusercontent.com/opherdonchin/ProbabilisticMachineLearning'
URLS = {
    'repository': 'https://github.com/opherdonchin/ProbabilisticMachineLearning',
    'pinned_commit_api': f'https://api.github.com/repos/opherdonchin/ProbabilisticMachineLearning/commits/{PIN}',
    'pinned_helper_blob': f'https://github.com/opherdonchin/ProbabilisticMachineLearning/blob/{PIN}/notebook_support/src/course_support/l01.py',
    'pinned_helper_raw': f'{BASE}/{PIN}/notebook_support/src/course_support/l01.py',
    'pinned_package_manifest_raw': f'{BASE}/{PIN}/notebook_support/pyproject.toml',
    'main_student_raw': f'{BASE}/main/InClass/lecture1_missing_data.ipynb',
    'main_solved_raw': f'{BASE}/main/InClass/Solutions/lecture1_missing_data.ipynb',
    'current_commit_student_raw': f'{BASE}/196e5e56a75f833e8a06f7077b951865487d61cd/InClass/lecture1_missing_data.ipynb',
    'main_readme_control': f'{BASE}/main/README.md',
}

def check(item):
    key, url = item
    req = urllib.request.Request(url, headers={'User-Agent': 'L01-release-readiness-read-only', 'Accept': '*/*'})
    try:
        response = urllib.request.urlopen(req, timeout=25)
    except urllib.error.HTTPError as exc:
        response = exc
    except Exception as exc:
        return key, {'url': url, 'error': repr(exc)}
    data = response.read()
    (OUT/f'http-{key}.body').write_bytes(data)
    (OUT/f'http-{key}.headers').write_text(str(response.headers))
    return key, {'url': url, 'final_url': response.geturl(), 'status': response.code, 'body_bytes': len(data), 'body_sha256': hashlib.sha256(data).hexdigest(), 'content_type': response.headers.get('Content-Type'), 'error_body_excerpt': data[:250].decode(errors='replace') if response.code >= 400 else None}

with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
    results = dict(executor.map(check, URLS.items()))
report = {'checked_at_utc': datetime.datetime.now(datetime.timezone.utc).isoformat(), 'auth': 'Anonymous GET only, no upload or credential use.', 'results': results}
(OUT/'public-access.json').write_text(json.dumps(report, indent=2)+'\n')
print(json.dumps(report, indent=2))
