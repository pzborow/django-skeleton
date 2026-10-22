import os
import time

import httpx
import pytest


@pytest.fixture(scope="session")
def http():
    """Klient do działającego serwera (adres z E2E_BASE_URL), czeka, aż serwer zacznie odpowiadać."""
    with httpx.Client(base_url=os.environ["E2E_BASE_URL"], follow_redirects=False) as client:
        deadline = time.monotonic() + 60
        while True:
            try:
                client.get("/")
                break
            except httpx.TransportError:
                if time.monotonic() > deadline:
                    raise
                time.sleep(1)
        yield client
