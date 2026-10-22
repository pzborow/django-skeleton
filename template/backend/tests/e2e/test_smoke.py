import httpx


def test_panel_admina_odpowiada(http: httpx.Client) -> None:
    assert http.get("/admin/login/").status_code == 200
