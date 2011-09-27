/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_pegawai_cetak_laporan_kepegawaian_identitas_guru;
var m_adm_pegawai_cetak_laporan_kepegawaian_identitas_guru_id_pegawai;
var m_adm_pegawai_cetak_laporan_kepegawaian_identitas_guru_d = _g_root +'/module/adm_pegawai_cetak_laporan_kepegawaian_identitas_guru/';

function M_AdmPegawaiCetakLaporanKepegawaianIdentitasGuru(title)
{
	this.title				= title;
	this.pageSize			= 50;
	this.ha_level			= 0;
	this.id_report			= '332';
	this.tipe_report		= 'doc';

	this.record = new Ext.data.Record.create([
			{ name	: 'id_pegawai' }
		,	{ name	: 'nip' }
		,	{ name	: 'nuptk' }
		,	{ name	: 'nm_pegawai' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_pegawai_cetak_laporan_kepegawaian_identitas_guru_d +'data.jsp'
		,	autoLoad	: false
	});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'NIP'
			, dataIndex		: 'nip'
			, sortable		: true
			, align			: 'center'
			, width			: 150
			, filterable	: true
			}
		,	{ header		: 'NUPTK'
			, dataIndex		: 'nuptk'
			, sortable		: true
			, align			: 'center'
			, width			: 150
			, filterable	: true
			}
		,	{ id			: 'nm_pegawai'
			, header		: 'Nama Pegawai'
			, dataIndex		: 'nm_pegawai'
			, sortable		: true
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners		: {
					scope			: this
				,	selectionchange	: function(sm) {
						var data = sm.getSelections();
						if (data.length) {
							m_adm_pegawai_cetak_laporan_kepegawaian_identitas_guru_id_pegawai = data[0].data['id_pegawai'];
							this.btn_print.setDisabled(false);
						} else {
							m_adm_pegawai_cetak_laporan_kepegawaian_identitas_guru_id_pegawai = '';
							this.btn_print.setDisabled(true);
						}
					}
			}
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.btn_print = new Ext.Button({
			text		: 'Cetak'
		,	iconCls		: 'print16'
		,	scope		: this
		,	disabled	: true
		,	handler		: function() {
				this.do_print();
			}
	});

	this.tbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'->'
		,	this.btn_print
		]
	});

	this.panel = new Ext.grid.GridPanel({
			id					: 'adm_pegawai_cetak_laporan_kepegawaian_identitas_guru_panel'
		,	title				: this.title
		,	store				: this.store
		,	sm					: this.sm
		,	columns				: this.columns
		,	stripeRows			: true
		,	columnLines			: true
		,	plugins				: [this.filters]
		,	autoExpandColumn	: 'nm_pegawai'
		,	tbar				: this.tbar
		,	bbar				: new Ext.PagingToolbar({
									store			: this.store
								,	pageSize		: this.pageSize
								,	firstText		: 'Halaman Awal'
								,	prevText		: 'Halaman Sebelumnya'
								,	beforePageText	: 'Halaman'
								,	afterPageText	: 'dari {0}'
								,	nextText		: 'Halaman Selanjutnya'
								,	lastText		: 'Halaman Terakhir'
								,	plugins			: [this.filters]
								})
	});

	this.do_print = function()
	{
		if (m_adm_pegawai_cetak_laporan_kepegawaian_identitas_guru_id_pegawai == ''){
			return;
		}
		
		var form;
		form = document.createElement('form');

		form.setAttribute('method', 'post');
		form.setAttribute('target', '_blank');		
		form.setAttribute('action', _g_root +'/report');
		
		var hiddenField1 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
        hiddenField1.setAttribute('name', 'id');
        hiddenField1.setAttribute('value', this.id_report);
		
		var hiddenField2 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField2.setAttribute('name', 'type');
        hiddenField2.setAttribute('value', this.tipe_report);

		var hiddenField3 = document.createElement ('input');
        hiddenField1.setAttribute('type', 'hidden');
		hiddenField3.setAttribute('name', 'id_pegawai');
        hiddenField3.setAttribute('value', m_adm_pegawai_cetak_laporan_kepegawaian_identitas_guru_id_pegawai);
		
		form.appendChild(hiddenField1);
		form.appendChild(hiddenField2);
		form.appendChild(hiddenField3);
		document.body.appendChild(form);
		form.submit();
	}
	
	this.do_load = function()
	{
		delete this.store.lastParams;
		
		this.store.load({
			params	: {
				start	: 0
			,	limit	: this.pageSize
			}
		});
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.panel.setDisabled(true);
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

m_adm_pegawai_cetak_laporan_kepegawaian_identitas_guru = new M_AdmPegawaiCetakLaporanKepegawaianIdentitasGuru('Laporan Identitas Guru');

//@ sourceURL=adm_pegawai_cetak_laporan_kepegawaian_identitas_guru.layout.js
