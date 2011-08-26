/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_nasional_kesiswaan_kesejahteraan_keluarga;
var m_ref_nasional_kesiswaan_kesejahteraan_keluarga_d = _g_root +'/module/ref_nasional_kesiswaan_kesejahteraan_keluarga/';

function M_RefNasionalKesiswaanKesejahteraanKeluarga(title)
{
	this.title	= title;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_kesejahteraan_keluarga' }
		,	{ name	: 'nm_kesejahteraan_keluarga' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields	: this.record
		,	url		: m_ref_nasional_kesiswaan_kesejahteraan_keluarga_d + 'data.jsp'
		,	autoLoad: false
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header	: 'Kode'
			, dataIndex	: 'kd_kesejahteraan_keluarga'
			, sortable	: true
			, width		: '100'
			, align		: 'center'
			}
		,	{ id		: 'nm_kesejahteraan_keluarga'
			, header	: 'Nama Kesejahteraan Keluarga'
			, dataIndex	: 'nm_kesejahteraan_keluarga'
			, sortable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.panel = new Ext.grid.GridPanel({
			id			: 'ref_nasional_kesiswaan_kesejahteraan_keluarga_panel'
		,	title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_kesejahteraan_keluarga'
	});

	this.do_load = function()
	{
		this.store.reload();
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (ha_level < 1) {
			this.panel.setDisabled(true);
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

m_ref_nasional_kesiswaan_kesejahteraan_keluarga = new M_RefNasionalKesiswaanKesejahteraanKeluarga('Kesejahteraan Keluarga');

//@ sourceURL=ref_nasional_kesiswaan_kesejahteraan_keluarga.layout.js
