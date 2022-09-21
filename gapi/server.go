package gapi

import (
	"fmt"

	db "github.com/mikhelbriones/simplebank/db/sqlc"
	"github.com/mikhelbriones/simplebank/pb"
	"github.com/mikhelbriones/simplebank/token"
	"github.com/mikhelbriones/simplebank/util"
)

// Server serves HTTP request for our banking service.
type Server struct {
	pb.UnimplementedSimplebankServer
	config     util.Config
	store      db.Store
	tokenMaker token.Maker
}

func NewServer(config util.Config, store db.Store) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TokenSymmetricKey)
	if err != nil {
		return nil, fmt.Errorf("cannot create token maker: %v", err)
	}

	server := &Server{
		config:     config,
		store:      store,
		tokenMaker: tokenMaker,
	}

	return server, nil
}
