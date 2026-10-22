def test_panel_admina_odpowiada(http):
    assert http.get("/admin/login/").status_code == 200
