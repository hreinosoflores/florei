package com.florei.api.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.florei.api.model.GrupoVenta;
import com.florei.api.repo.GrupoVentaRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/grupoventa")
@CrossOrigin
public class GrupoVentaController {
	@Autowired
	private GrupoVentaRepository grupoVentaRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, grupoVentaRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody GrupoVenta grupoVenta) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			grupoVenta.getAuditoria().setActivo(true);
			grupoVenta.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, grupoVentaRepository.save(grupoVenta));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody GrupoVenta grupoVenta) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			grupoVenta.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, grupoVentaRepository.save(grupoVenta));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			grupoVentaRepository.deleteById(id);
			Global.resultOK(result, id);
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PatchMapping("/activo/{usu}/{id}")
	public Map<String, Object> toggleActivo(@PathVariable Long usu, @PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			GrupoVenta grupoVenta = grupoVentaRepository.findById(id).orElse(null);
			if (grupoVenta != null) {
				grupoVenta.getAuditoria().setActivo(!grupoVenta.getAuditoria().getActivo());
				grupoVenta.getAuditoria().setFechaModificacion(new Date());
				grupoVenta.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, grupoVentaRepository.save(grupoVenta));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
