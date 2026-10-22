import pytest
from django.db import connection


@pytest.mark.django_db
def test_baza_odpowiada():
    with connection.cursor() as cursor:
        cursor.execute("SELECT 1")
        assert cursor.fetchone() == (1,)
