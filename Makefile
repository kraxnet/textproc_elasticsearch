# New ports collection makefile for:	elasticsearch
# Date created:		2011-03-07
# Whom:			Jiri Kubicek <jiri.kubicek@kraxnet.cz>
#
# $FreeBSD$
#

PORTNAME=	elasticsearch
PORTVERSION=	0.19.4
CATEGORIES=	textproc java
MASTER_SITES=	http://github.com/downloads/elasticsearch/elasticsearch/

MAINTAINER=	jiri.kubicek@kraxnet.cz
COMMENT=	Open Source (Apache 2), Distributed, RESTful, Search Engine built on top of Lucene

FETCH_ARGS=    -pRr    # default '-ApRr' prevents 302 redirects by github

JAVA_OS=	native
JAVA_VENDOR=	freebsd
JAVA_VERSION=	1.5+
NO_BUILD=	yes
PLIST_SUB+=	PORTVERSION="${PORTVERSION}"
USE_JAVA=	yes

ELASTICSEARCH_USER?=    elasticsearch
ELASTICSEARCH_GROUP?=	elasticsearch
ELASTICSEARCH_VARDIR?=  /var
ELASTICSEARCH_CONFDIR?= ${PREFIX}/etc/elasticsearch
ELASTICSEARCH_LOGDIR?=  ${ELASTICSEARCH_VARDIR}/log/elasticsearch
ELASTICSEARCH_DATADIR?= ${ELASTICSEARCH_VARDIR}/db/elasticsearch
ELASTICSEARCH_WORKDIR?= ${ELASTICSEARCH_VARDIR}/db/elasticsearch/work

USE_RC_SUBR=    elasticsearch

SUB_LIST+=      PREFIX=${PREFIX} ELASTICSEARCH_CONFDIR=${ELASTICSEARCH_CONFDIR} ELASTICSEARCH_LOGDIR=${ELASTICSEARCH_LOGDIR} ELASTICSEARCH_DATADIR=${ELASTICSEARCH_DATADIR} ELASTICSEARCH_WORKDIR=${ELASTICSEARCH_WORKDIR} ELASTICSEARCH_USER=${ELASTICSEARCH_USER} ELASTICSEARCH_GROUP=${ELASTICSEARCH_GROUP}
SUB_FILES=	pkg-install

.include <bsd.port.pre.mk>

pre-install:
	@${SH} ${PKGINSTALL} ${PORTNAME} PRE-INSTALL

do-install:
	${INSTALL} -d ${PREFIX}/etc/${PORTNAME}
	${CP} -R ${WRKSRC}/lib/ ${JAVAJARDIR}
	${CP} ${WRKSRC}/config/elasticsearch.yml ${DESTDIR}$(PREFIX)/etc/elasticsearch
	${CP} ${WRKSRC}/config/logging.yml ${DESTDIR}$(PREFIX)/etc/elasticsearch

post-install:
	@${SH} ${PKGINSTALL} ${PKGNAME} POST-INSTALL

.include <bsd.port.post.mk>
